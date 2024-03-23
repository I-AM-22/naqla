import { MigrationInterface, QueryRunner } from 'typeorm';

export class NewPhoneOtp1709577021358 implements MigrationInterface {
  name = 'NewPhoneOtp1709577021358';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "users" ADD "newPhone" character varying`,
    );
    await queryRunner.query(
      `ALTER TABLE "users" ADD CONSTRAINT "UQ_922139656153d80146e87014405" UNIQUE ("newPhone")`,
    );
    await queryRunner.query(`ALTER TABLE "users" ADD "otpExpiresIn" TIMESTAMP`);
    await queryRunner.query(
      `ALTER TABLE "users" ADD "otpForNum" character varying`,
    );
    await queryRunner.query(
      `ALTER TABLE "users" ADD "otpForNumExpiresIn" TIMESTAMP`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "users" DROP COLUMN "otpForNumExpiresIn"`,
    );
    await queryRunner.query(`ALTER TABLE "users" DROP COLUMN "otpForNum"`);
    await queryRunner.query(`ALTER TABLE "users" DROP COLUMN "otpExpiresIn"`);
    await queryRunner.query(
      `ALTER TABLE "users" DROP CONSTRAINT "UQ_922139656153d80146e87014405"`,
    );
    await queryRunner.query(`ALTER TABLE "users" DROP COLUMN "newPhone"`);
  }
}
