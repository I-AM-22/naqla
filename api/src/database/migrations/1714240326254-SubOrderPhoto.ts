import { MigrationInterface, QueryRunner } from 'typeorm';

export class SubOrderPhoto1714240326254 implements MigrationInterface {
  name = 'SubOrderPhoto1714240326254';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ADD "status" character varying NOT NULL DEFAULT 'ready'`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders_photos" ADD "subOrderId" uuid`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders_photos" ADD CONSTRAINT "FK_e0ff4d914fdab3041b394104bcb" FOREIGN KEY ("subOrderId") REFERENCES "sub_orders"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "orders_photos" DROP CONSTRAINT "FK_e0ff4d914fdab3041b394104bcb"`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders_photos" DROP COLUMN "subOrderId"`,
    );
    await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "status"`);
  }
}
