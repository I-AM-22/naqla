import { MigrationInterface, QueryRunner } from "typeorm";

export class Note1720809499658 implements MigrationInterface {
    name = 'Note1720809499658'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "note" character varying`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "note"`);
    }

}
