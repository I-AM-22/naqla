import { MigrationInterface, QueryRunner } from 'typeorm';

export class OrderPayment1711452616125 implements MigrationInterface {
  name = 'OrderPayment1711452616125';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `CREATE TABLE "payments" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "total" integer DEFAULT '0', "additionalCost" integer DEFAULT '0', "deliveredDate" TIMESTAMP, "orderId" uuid NOT NULL, CONSTRAINT "REL_af929a5f2a400fdb6913b4967e" UNIQUE ("orderId"), CONSTRAINT "PK_197ab7af18c93fbb0c9b28b4a59" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(`ALTER TABLE "orders" DROP COLUMN "cost"`);
    await queryRunner.query(
      `ALTER TABLE "orders" ADD "paymentId" uuid NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders" ADD CONSTRAINT "UQ_06a051324c76276ca2a9d1feb08" UNIQUE ("paymentId")`,
    );
    await queryRunner.query(
      `ALTER TABLE "payments" ADD CONSTRAINT "FK_af929a5f2a400fdb6913b4967e1" FOREIGN KEY ("orderId") REFERENCES "orders"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders" ADD CONSTRAINT "FK_06a051324c76276ca2a9d1feb08" FOREIGN KEY ("paymentId") REFERENCES "payments"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "orders" DROP CONSTRAINT "FK_06a051324c76276ca2a9d1feb08"`,
    );
    await queryRunner.query(
      `ALTER TABLE "payments" DROP CONSTRAINT "FK_af929a5f2a400fdb6913b4967e1"`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders" DROP CONSTRAINT "UQ_06a051324c76276ca2a9d1feb08"`,
    );
    await queryRunner.query(`ALTER TABLE "orders" DROP COLUMN "paymentId"`);
    await queryRunner.query(`ALTER TABLE "orders" DROP COLUMN "desiredDate"`);
    await queryRunner.query(`ALTER TABLE "orders" ADD "cost" integer NOT NULL`);
    await queryRunner.query(
      `ALTER TABLE "orders" ADD "receiving_date" TIMESTAMP NOT NULL`,
    );
    await queryRunner.query(`DROP TABLE "payments"`);
  }
}
