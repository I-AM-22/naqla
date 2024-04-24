import { MigrationInterface, QueryRunner } from 'typeorm';

export class SubOrders1713698601790 implements MigrationInterface {
  name = 'SubOrders1713698601790';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `CREATE TABLE "sub_orders" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "rating" integer NOT NULL DEFAULT '0', "cost" integer NOT NULL DEFAULT '0', "arrivalDate" character varying, "deliveryDate" character varying, "orderId" uuid NOT NULL, "carId" uuid NOT NULL, CONSTRAINT "PK_8a12f41dc8b11c5f447a50ccbff" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(`ALTER TABLE "payments" DROP COLUMN "total"`);
    await queryRunner.query(
      `ALTER TABLE "payments" ADD "cost" integer NOT NULL DEFAULT '0'`,
    );
    await queryRunner.query(
      `ALTER TABLE "payments" ALTER COLUMN "additionalCost" SET NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ADD CONSTRAINT "FK_b161e25190098665c5453738b6a" FOREIGN KEY ("orderId") REFERENCES "orders"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ADD CONSTRAINT "FK_c37e665310aec76063e9b92b441" FOREIGN KEY ("carId") REFERENCES "cars"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "sub_orders" DROP CONSTRAINT "FK_c37e665310aec76063e9b92b441"`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" DROP CONSTRAINT "FK_b161e25190098665c5453738b6a"`,
    );
    await queryRunner.query(
      `ALTER TABLE "payments" ALTER COLUMN "additionalCost" DROP NOT NULL`,
    );
    await queryRunner.query(`ALTER TABLE "payments" DROP COLUMN "cost"`);
    await queryRunner.query(
      `ALTER TABLE "payments" ADD "total" integer DEFAULT '0'`,
    );
    await queryRunner.query(`DROP TABLE "sub_orders"`);
  }
}
