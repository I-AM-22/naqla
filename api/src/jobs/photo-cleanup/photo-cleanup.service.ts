import { Injectable } from '@nestjs/common';
import * as fs from 'fs';
import * as path from 'path';

@Injectable()
export class PhotoCleanupService {
  async deletePhotosOlderThanDays(): Promise<void> {
    const now = new Date();
    now.setDate(now.getDate() - 1);

    // Iterate through files in the directory
    const dir = path.join(__dirname, '..', '..', '..', 'public', 'photos');
    fs.readdir(dir, (err, files) => {
      if (err) {
        throw err;
      }

      for (const file of files) {
        const filePath = path.join(dir, file);
        const fileStats = fs.statSync(filePath);

        // Check if the file's modification date is older than 'days'
        if (fileStats.mtime < now) {
          fs.unlinkSync(filePath); // Delete the file
        }
      }
    });
  }
}
