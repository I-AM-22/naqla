import * as path from 'path';
import * as fs from 'fs';
import sharp from 'sharp';

export const customize = async (image: Express.Multer.File) => {
  const folderPath = path.join(__dirname, '..', '..', '..', 'public', 'photos');

  if (!fs.existsSync(folderPath)) {
    fs.mkdirSync(folderPath, {
      recursive: true,
    });
  }

  const randomName = Array(32)
    .fill(null)
    .map(() => Math.round(Math.random() * 16).toString(16))
    .join('');

  const filename = `${randomName}${path.extname(image.originalname)}`;
  await sharp(image.buffer)
    .resize({ width: 1100, height: 700 })
    .ensureAlpha()
    .raw()
    .toFormat('jpg')
    .jpeg({
      quality: 80,
      chromaSubsampling: '4:4:4',
      progressive: true,
      optimizeCoding: true,
      trellisQuantisation: true,
      overshootDeringing: true,
      optimizeScans: true,
      mozjpeg: true,
      quantisationTable: 0,
    })
    .toFile(path.join(folderPath, filename));

  return filename;
};
