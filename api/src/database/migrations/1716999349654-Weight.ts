import { MigrationInterface, QueryRunner } from 'typeorm';

export class Weight1716999349654 implements MigrationInterface {
  name = 'Weight1716999349654';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "sub_orders" DROP COLUMN "arrivalDate"`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" DROP COLUMN "deliveryDate"`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ADD "weight" integer NOT NULL DEFAULT '0'`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ADD "acceptedAt" character varying`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ADD "arrivedAt" character varying`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ADD "deliveredAt" character varying`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ADD "driverAssignedAt" character varying`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ADD "pickedUpAt" character varying`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "sub_orders" DROP COLUMN "pickedUpAt"`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" DROP COLUMN "driverAssignedAt"`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" DROP COLUMN "deliveredAt"`,
    );
    await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "arrivedAt"`);
    await queryRunner.query(
      `ALTER TABLE "sub_orders" DROP COLUMN "acceptedAt"`,
    );
    await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "weight"`);
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ADD "deliveryDate" character varying`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ADD "arrivalDate" character varying`,
    );
  }
}
