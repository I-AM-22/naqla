import { MigrationInterface, QueryRunner } from "typeorm";

export class AddMethodType21722090806317 implements MigrationInterface {
    name = 'AddMethodType21722090806317'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "payments" ADD "status" character varying NOT NULL DEFAULT 'pending'`);
        await queryRunner.query(`ALTER TABLE "payments" ADD "methodType" character varying NOT NULL DEFAULT ''`);
        await queryRunner.query(`ALTER TABLE "payments" ADD "reference" character varying NOT NULL DEFAULT ''`);
        await queryRunner.query(`ALTER TABLE "payments" ADD "transactionId" character varying NOT NULL DEFAULT ''`);
        await queryRunner.query(`ALTER TABLE "drivers" ADD "disactiveAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "users" ADD "disactiveAt" TIMESTAMP`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "users" DROP COLUMN "disactiveAt"`);
        await queryRunner.query(`ALTER TABLE "drivers" DROP COLUMN "disactiveAt"`);
        await queryRunner.query(`ALTER TABLE "payments" DROP COLUMN "transactionId"`);
        await queryRunner.query(`ALTER TABLE "payments" DROP COLUMN "reference"`);
        await queryRunner.query(`ALTER TABLE "payments" DROP COLUMN "methodType"`);
        await queryRunner.query(`ALTER TABLE "payments" DROP COLUMN "status"`);
    }

}
