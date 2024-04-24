import { MigrationInterface, QueryRunner } from 'typeorm';

export class CarPhotos1713446160306 implements MigrationInterface {
  name = 'CarPhotos1713446160306';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "cars_photos" DROP CONSTRAINT "FK_e849099cf387e9ac4e18485c03f"`,
    );
    await queryRunner.query(
      `ALTER TABLE "cars_photos" DROP CONSTRAINT "REL_e849099cf387e9ac4e18485c03"`,
    );
    await queryRunner.query(
      `ALTER TABLE "cars_photos" ADD CONSTRAINT "FK_e849099cf387e9ac4e18485c03f" FOREIGN KEY ("carId") REFERENCES "cars"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "cars_photos" DROP CONSTRAINT "FK_e849099cf387e9ac4e18485c03f"`,
    );
    await queryRunner.query(
      `ALTER TABLE "cars_photos" ADD CONSTRAINT "REL_e849099cf387e9ac4e18485c03" UNIQUE ("carId")`,
    );
    await queryRunner.query(
      `ALTER TABLE "cars_photos" ADD CONSTRAINT "FK_e849099cf387e9ac4e18485c03f" FOREIGN KEY ("carId") REFERENCES "cars"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
  }
}
