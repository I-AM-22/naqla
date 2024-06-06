import { MigrationInterface, QueryRunner } from 'typeorm';

export class Settings1713916111749 implements MigrationInterface {
  name = 'Settings1713916111749';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "sub_orders" DROP CONSTRAINT "FK_c37e665310aec76063e9b92b441"`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" DROP CONSTRAINT "FK_b161e25190098665c5453738b6a"`,
    );
    await queryRunner.query(
      `CREATE TABLE "settings" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "name" character varying NOT NULL, "cost" integer NOT NULL DEFAULT '0', CONSTRAINT "UQ_ca7857276d2a30f4dcfa0e42cd4" UNIQUE ("name"), CONSTRAINT "PK_0669fe20e252eb692bf4d344975" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ADD CONSTRAINT "FK_99d5f29c6ea3cfca35f10759984" FOREIGN KEY ("orderId") REFERENCES "orders"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
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
      `ALTER TABLE "sub_orders" DROP CONSTRAINT "FK_99d5f29c6ea3cfca35f10759984"`,
    );
    await queryRunner.query(`DROP TABLE "settings"`);
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ADD CONSTRAINT "FK_b161e25190098665c5453738b6a" FOREIGN KEY ("orderId") REFERENCES "orders"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "sub_orders" ADD CONSTRAINT "FK_c37e665310aec76063e9b92b441" FOREIGN KEY ("carId") REFERENCES "cars"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
  }
}
