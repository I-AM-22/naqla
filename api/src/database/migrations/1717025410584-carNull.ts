import { MigrationInterface, QueryRunner } from 'typeorm';

export class CarNull1717025410584 implements MigrationInterface {
  name = 'CarNull1717025410584';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "sub_orders" DROP CONSTRAINT "FK_6aa2ccd7b620317ee004f7f73e0"`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ALTER COLUMN "carId" DROP NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ADD CONSTRAINT "FK_6aa2ccd7b620317ee004f7f73e0" FOREIGN KEY ("carId") REFERENCES "cars"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "sub_orders" DROP CONSTRAINT "FK_6aa2ccd7b620317ee004f7f73e0"`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ALTER COLUMN "carId" SET NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ADD CONSTRAINT "FK_6aa2ccd7b620317ee004f7f73e0" FOREIGN KEY ("carId") REFERENCES "cars"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
  }
}
