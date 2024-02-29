import { Injectable } from '@nestjs/common';
import { Request } from 'express';

@Injectable()
export class PhotosService {
  uploadSingle(photo: string, req: Request) {
    const { protocol } = req;
    const host = req.get('Host');
    const fullUrl = protocol + '://' + host + '/';
    return fullUrl + 'photos/' + photo;
  }

  uploadMultiple(photos: string[], req: Request) {
    const links = photos.map((e) => this.uploadSingle(e, req));
    return links;
  }
}
