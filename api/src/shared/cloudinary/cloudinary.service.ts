import { HttpException, Inject, Injectable } from '@nestjs/common';
import * as cloudinary from 'cloudinary';
import { ConfigType } from '@nestjs/config';
import { CheckUrl } from '../../common/types';
import { IPhoto } from '../../common/interfaces';
import { CloudinaryConfig } from '../../config/app';

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
    const result = cloudinary.v2.uploader.upload(
      path,
      {
        folder: 'Users',
      },
      (err) => {
        if (err) throw new HttpException(err.message, err.http_code);
      },
    );

    return result;
  }

  async FormatPhoto(
    result: cloudinary.UploadApiResponse,
    blurHash: string,
  ): Promise<IPhoto> {
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

  async uploadSinglePhoto({ path, blurHash }: CheckUrl) {
    const result = await this.uploadPhoto(path);
    return this.FormatPhoto(result, blurHash);
  }

  async uploadMultiplePhotos(res: CheckUrl[]) {
    const results = await Promise.all(res.map((e) => this.uploadPhoto(e.path)));
    return Promise.all(
      results.map((e, index: number) =>
        this.FormatPhoto(e, res[index].blurHash),
      ),
    );
  }
  async removePhoto(publicId: string) {
    return await cloudinary.v2.uploader.destroy(publicId, {
      resource_type: 'image',
    });
  }

  async removeMultiplePhotos(publicIds: string[]) {
    return await Promise.all(
      publicIds.map(async (p) => await this.removePhoto(p)),
    );
  }
}
