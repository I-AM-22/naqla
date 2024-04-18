import { MigrationInterface, QueryRunner } from 'typeorm';

export class OtpTech1709665494438 implements MigrationInterface {
  name = 'OtpTech1709665494438';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`ALTER TABLE "users" DROP COLUMN "otp"`);
    await queryRunner.query(
      `ALTER TABLE "users" DROP CONSTRAINT "UQ_922139656153d80146e87014405"`,
    );
    await queryRunner.query(`ALTER TABLE "users" DROP COLUMN "newPhone"`);
    await queryRunner.query(`ALTER TABLE "users" DROP COLUMN "otpExpiresIn"`);
    await queryRunner.query(`ALTER TABLE "users" DROP COLUMN "otpForNum"`);
    await queryRunner.query(
      `ALTER TABLE "users" DROP COLUMN "otpForNumExpiresIn"`,
    );
    await queryRunner.query(`ALTER TABLE "otps" ADD "userId" uuid NOT NULL`);
    await queryRunner.query(
      `ALTER TABLE "otps" ALTER COLUMN "expiresIn" SET DEFAULT '"2024-03-06T19:04:58.516Z"'`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "otps" ALTER COLUMN "expiresIn" DROP DEFAULT`,
    );
    await queryRunner.query(`ALTER TABLE "otps" DROP COLUMN "userId"`);
    await queryRunner.query(
      `ALTER TABLE "users" ADD "otpForNumExpiresIn" TIMESTAMP`,
    );
    await queryRunner.query(
      `ALTER TABLE "users" ADD "otpForNum" character varying`,
    );
    await queryRunner.query(`ALTER TABLE "users" ADD "otpExpiresIn" TIMESTAMP`);
    await queryRunner.query(
      `ALTER TABLE "users" ADD "newPhone" character varying`,
    );
    await queryRunner.query(
      `ALTER TABLE "users" ADD CONSTRAINT "UQ_922139656153d80146e87014405" UNIQUE ("newPhone")`,
    );
    await queryRunner.query(`ALTER TABLE "users" ADD "otp" character varying`);
  }
}
