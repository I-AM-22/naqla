import { MigrationInterface, QueryRunner } from 'typeorm';

export class Poraters1718137679668 implements MigrationInterface {
  name = 'Poraters1718137679668';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "orders" ADD "porters" integer NOT NULL DEFAULT '0'`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders_photos" ALTER COLUMN "weight" SET DEFAULT '0'`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders_photos" ALTER COLUMN "length" SET DEFAULT '0'`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders_photos" ALTER COLUMN "width" SET DEFAULT '0'`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "orders_photos" ALTER COLUMN "width" DROP DEFAULT`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders_photos" ALTER COLUMN "length" DROP DEFAULT`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders_photos" ALTER COLUMN "weight" DROP DEFAULT`,
    );
    await queryRunner.query(`ALTER TABLE "orders" DROP COLUMN "porters"`);
  }
}
