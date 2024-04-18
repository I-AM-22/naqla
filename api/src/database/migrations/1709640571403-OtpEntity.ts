import { MigrationInterface, QueryRunner } from 'typeorm';

export class OtpEntity1709640571403 implements MigrationInterface {
  name = 'OtpEntity1709640571403';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `CREATE TABLE "otps" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "phone" character varying NOT NULL, "otp" character varying NOT NULL, "expiresIn" TIMESTAMP NOT NULL, "type" character varying NOT NULL, "valid" boolean NOT NULL DEFAULT true, CONSTRAINT "PK_91fef5ed60605b854a2115d2410" PRIMARY KEY ("id"))`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`DROP TABLE "otps"`);
  }
}
