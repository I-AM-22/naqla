import { MigrationInterface, QueryRunner } from "typeorm";

export class RepeatDriver1721930594185 implements MigrationInterface {
    name = 'RepeatDriver1721930594185'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "repeatDriver" boolean`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "repeatDriver"`);
    }

}
