import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddItemToPhoto1717434037890 implements MigrationInterface {
  name = 'AddItemToPhoto1717434037890';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "orders_photos" ADD "weight" integer NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders_photos" ADD "length" integer NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders_photos" ADD "width" integer NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ALTER COLUMN "status" SET DEFAULT 'waiting'`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ALTER COLUMN "status" SET DEFAULT 'ready'`,
    );
    await queryRunner.query(`ALTER TABLE "orders_photos" DROP COLUMN "width"`);
    await queryRunner.query(`ALTER TABLE "orders_photos" DROP COLUMN "length"`);
    await queryRunner.query(`ALTER TABLE "orders_photos" DROP COLUMN "weight"`);
  }
}
