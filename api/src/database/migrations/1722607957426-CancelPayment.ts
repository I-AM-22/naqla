import { MigrationInterface, QueryRunner } from "typeorm";

export class CancelPayment1722607957426 implements MigrationInterface {
    name = 'CancelPayment1722607957426'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "payments" DROP COLUMN "status"`);
        await queryRunner.query(`ALTER TABLE "payments" DROP COLUMN "methodType"`);
        await queryRunner.query(`ALTER TABLE "payments" DROP COLUMN "reference"`);
        await queryRunner.query(`ALTER TABLE "payments" DROP COLUMN "transactionId"`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "payments" ADD "transactionId" character varying NOT NULL DEFAULT ''`);
        await queryRunner.query(`ALTER TABLE "payments" ADD "reference" character varying NOT NULL DEFAULT ''`);
        await queryRunner.query(`ALTER TABLE "payments" ADD "methodType" character varying NOT NULL DEFAULT ''`);
        await queryRunner.query(`ALTER TABLE "payments" ADD "status" character varying NOT NULL DEFAULT 'pending'`);
    }

}
