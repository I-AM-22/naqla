import { MigrationInterface, QueryRunner } from "typeorm";

export class Realcost1719513152262 implements MigrationInterface {
    name = 'Realcost1719513152262'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "realCost" integer NOT NULL DEFAULT '0'`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "acceptedAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "acceptedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "arrivedAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "arrivedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "deliveredAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "deliveredAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "driverAssignedAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "driverAssignedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "pickedUpAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "pickedUpAt" TIMESTAMP`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "pickedUpAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "pickedUpAt" character varying`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "driverAssignedAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "driverAssignedAt" character varying`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "deliveredAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "deliveredAt" character varying`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "arrivedAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "arrivedAt" character varying`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "acceptedAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "acceptedAt" character varying`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "realCost"`);
    }

}
