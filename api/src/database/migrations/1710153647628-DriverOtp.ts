import { MigrationInterface, QueryRunner } from 'typeorm';

export class DriverOtp1710153647628 implements MigrationInterface {
  name = 'DriverOtp1710153647628';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `CREATE TABLE "drivers_photos" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "publicId" character varying NOT NULL, "blurHash" character varying NOT NULL, "profileUrl" character varying NOT NULL, "mobileUrl" character varying NOT NULL, "webUrl" character varying NOT NULL, "driverId" uuid NOT NULL, CONSTRAINT "PK_cbb7814f34d7ac77c81d5b83a2a" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "drivers_wallets" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "driverId" uuid NOT NULL, "total" integer NOT NULL DEFAULT '0', "pending" integer NOT NULL DEFAULT '0', CONSTRAINT "REL_af1ef2ab6787d92180930ecbbb" UNIQUE ("driverId"), CONSTRAINT "PK_633bb1b321a5cdbfec2f3039394" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `ALTER TABLE "drivers" ADD "active" boolean NOT NULL DEFAULT false`,
    );
    await queryRunner.query(`ALTER TABLE "drivers" ADD "roleId" uuid NOT NULL`);
    await queryRunner.query(
      `ALTER TABLE "otps" ADD "perType" character varying NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "otps" ALTER COLUMN "expiresIn" DROP DEFAULT`,
    );
    await queryRunner.query(
      `ALTER TABLE "drivers_photos" ADD CONSTRAINT "FK_398df1713b211d26e95ce082d5d" FOREIGN KEY ("driverId") REFERENCES "drivers"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "drivers_wallets" ADD CONSTRAINT "FK_af1ef2ab6787d92180930ecbbb9" FOREIGN KEY ("driverId") REFERENCES "drivers"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "drivers" ADD CONSTRAINT "FK_f38c16252a31e8c369059ce6154" FOREIGN KEY ("roleId") REFERENCES "roles"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "drivers" DROP CONSTRAINT "FK_f38c16252a31e8c369059ce6154"`,
    );
    await queryRunner.query(
      `ALTER TABLE "drivers_wallets" DROP CONSTRAINT "FK_af1ef2ab6787d92180930ecbbb9"`,
    );
    await queryRunner.query(
      `ALTER TABLE "drivers_photos" DROP CONSTRAINT "FK_398df1713b211d26e95ce082d5d"`,
    );
    await queryRunner.query(
      `ALTER TABLE "otps" ALTER COLUMN "expiresIn" SET DEFAULT '2024-03-06 19:04:58.516'`,
    );
    await queryRunner.query(`ALTER TABLE "otps" DROP COLUMN "perType"`);
    await queryRunner.query(`ALTER TABLE "drivers" DROP COLUMN "roleId"`);
    await queryRunner.query(`ALTER TABLE "drivers" DROP COLUMN "active"`);
    await queryRunner.query(`DROP TABLE "drivers_wallets"`);
    await queryRunner.query(`DROP TABLE "drivers_photos"`);
  }
}
