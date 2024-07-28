import { HttpException, Inject, Injectable } from '@nestjs/common';
import * as cloudinary from 'cloudinary';
import { ConfigType } from '@nestjs/config';
import { IPhoto } from '@common/interfaces';
import { CloudinaryConfig } from '@config/app';
import { createBlurHash, createBlurHashs } from '@common/helpers';

@Injectable()
export class CloudinaryService {
  constructor(
    @Inject(CloudinaryConfig.KEY)
    private readonly cloudinaryConfig: ConfigType<typeof CloudinaryConfig>,
  ) {
    cloudinary.v2.config({
      cloud_name: this.cloudinaryConfig.cloud_name,
      api_key: this.cloudinaryConfig.api_key,
      api_secret: this.cloudinaryConfig.api_secret,
    });
  }

  async uploadPhoto(path: string): Promise<cloudinary.UploadApiResponse> {
    try {
      const result = await cloudinary.v2.uploader.upload(path, {
        folder: 'Users',
      });
      return result;
    } catch (err) {
      throw new HttpException(err.message, err.http_code || 400);
    }
  }

  async FormatPhoto(result: cloudinary.UploadApiResponse, blurHash: string): Promise<IPhoto> {
    const mobileUrl = cloudinary.v2.url(result.public_id, {
      secure: true,
      transformation: ['mobile'],
    });

    const profileUrl = cloudinary.v2.url(result.public_id, {
      secure: true,
      transformation: ['profile'],
    });

    return {
      blurHash,
      webUrl: result.secure_url,
      mobileUrl,
      profileUrl,
      publicId: result.public_id,
    };
  }

  async uploadSinglePhoto(path: string) {
    const blurHash = await createBlurHash(path);
    const result = await this.uploadPhoto(path);
    return this.FormatPhoto(result, blurHash);
  }

  async uploadMultiplePhotos(paths: string[]) {
    const blurHashs = await createBlurHashs(paths);
    const results = await Promise.all(paths.map((e) => this.uploadPhoto(e)));
    return await Promise.all(results.map((e, i) => this.FormatPhoto(e, blurHashs[i])));
  }

  async removePhoto(publicId: string) {
    return await cloudinary.v2.uploader.destroy(publicId, {
      resource_type: 'image',
    });
  }

  async removeMultiplePhotos(publicIds: string[]) {
    return await Promise.all(publicIds.map(async (p) => await this.removePhoto(p)));
  }
}
