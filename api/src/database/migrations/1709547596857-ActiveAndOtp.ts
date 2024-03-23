import { MigrationInterface, QueryRunner } from 'typeorm';

export class ActiveAndOtp1709547596857 implements MigrationInterface {
  name = 'ActiveAndOtp1709547596857';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`ALTER TABLE "employees" DROP COLUMN "storeId"`);
    await queryRunner.query(`ALTER TABLE "users" DROP COLUMN "password"`);
    await queryRunner.query(
      `ALTER TABLE "users" DROP COLUMN "passwordChangedAt"`,
    );
    await queryRunner.query(
      `ALTER TABLE "users" DROP CONSTRAINT "UQ_bffe933a388d6bde48891ff95ab"`,
    );
    await queryRunner.query(
      `ALTER TABLE "users" DROP COLUMN "passwordResetToken"`,
    );
    await queryRunner.query(
      `ALTER TABLE "users" DROP COLUMN "passwordResetExpires"`,
    );
    await queryRunner.query(`ALTER TABLE "drivers" DROP COLUMN "password"`);
    await queryRunner.query(
      `ALTER TABLE "drivers" DROP COLUMN "passwordChangedAt"`,
    );
    await queryRunner.query(
      `ALTER TABLE "drivers" DROP CONSTRAINT "UQ_f8e32d615cfd3bceecd6fec2331"`,
    );
    await queryRunner.query(
      `ALTER TABLE "drivers" DROP COLUMN "passwordResetToken"`,
    );
    await queryRunner.query(
      `ALTER TABLE "drivers" DROP COLUMN "passwordResetExpires"`,
    );
    await queryRunner.query(
      `ALTER TABLE "users" ADD "active" boolean NOT NULL DEFAULT false`,
    );
    await queryRunner.query(`ALTER TABLE "users" ADD "otp" character varying`);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`ALTER TABLE "users" DROP COLUMN "otp"`);
    await queryRunner.query(`ALTER TABLE "users" DROP COLUMN "active"`);
    await queryRunner.query(
      `ALTER TABLE "drivers" ADD "passwordResetExpires" TIMESTAMP`,
    );
    await queryRunner.query(
      `ALTER TABLE "drivers" ADD "passwordResetToken" character varying`,
    );
    await queryRunner.query(
      `ALTER TABLE "drivers" ADD CONSTRAINT "UQ_f8e32d615cfd3bceecd6fec2331" UNIQUE ("passwordResetToken")`,
    );
    await queryRunner.query(
      `ALTER TABLE "drivers" ADD "passwordChangedAt" TIMESTAMP`,
    );
    await queryRunner.query(
      `ALTER TABLE "drivers" ADD "password" character varying NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "users" ADD "passwordResetExpires" TIMESTAMP`,
    );
    await queryRunner.query(
      `ALTER TABLE "users" ADD "passwordResetToken" character varying`,
    );
    await queryRunner.query(
      `ALTER TABLE "users" ADD CONSTRAINT "UQ_bffe933a388d6bde48891ff95ab" UNIQUE ("passwordResetToken")`,
    );
    await queryRunner.query(
      `ALTER TABLE "users" ADD "passwordChangedAt" TIMESTAMP`,
    );
    await queryRunner.query(
      `ALTER TABLE "users" ADD "password" character varying NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "employees" ADD "storeId" character varying NOT NULL`,
    );
  }
}
