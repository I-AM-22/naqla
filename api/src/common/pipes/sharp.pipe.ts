import { BadRequestException, Injectable, PipeTransform } from '@nestjs/common';
import { customize } from '../helpers';

@Injectable()
export class SharpPipe implements PipeTransform<Express.Multer.File, Promise<string | string[]>> {
  async transform(image: Express.Multer.File & { photos: Express.Multer.File[] }): Promise<string | string[]> {
    if (!image) {
      throw new BadRequestException('Please upload at least one photo');
    }
    if (Array.isArray(image.photos)) {
      const { photos }: { photos: Express.Multer.File[] } = image;
      return Promise.all(photos.map((e) => customize(e)));
    }
    return customize(image);
  }
}
