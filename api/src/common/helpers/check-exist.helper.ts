import { encode } from 'blurhash';
import * as fs from 'fs';
import { CheckUrl } from '../types';
import sharp from 'sharp';

export const createBlurHash = async (path: string): Promise<CheckUrl> => {
  const image = fs.readFileSync(path);
  const { info, data } = await sharp(image)
    .resize(200, 200)
    .ensureAlpha()
    .raw()
    .toBuffer({ resolveWithObject: true });

  const blurHash = encode(
    new Uint8ClampedArray(data),
    info.width,
    info.height,
    4,
    4,
  );
  return { path, blurHash };
};

export const createBlurHashs = async (paths: string[]) => {
  const res = await Promise.all(
    paths.map(async (p) => await createBlurHash(p)),
  );
  return res;
};

export const getPhotosPath = (url: string[]) => {
  return url.map((p: string) => getPhotoPath(p));
};

export const getPhotoPath = (p: string) => {
  const dir = p.substring(p.indexOf('/photos'));
  const path = `public${dir}`;
  return path;
};
