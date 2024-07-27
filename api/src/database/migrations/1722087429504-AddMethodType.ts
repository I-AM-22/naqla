import { MigrationInterface, QueryRunner } from "typeorm";

export class AddMethodType1722087429504 implements MigrationInterface {
    name = 'AddMethodType1722087429504'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "payments" ALTER COLUMN "methodType" SET DEFAULT ''`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "payments" ALTER COLUMN "methodType" DROP DEFAULT`);
    }

}
