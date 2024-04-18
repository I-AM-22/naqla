import { MigrationInterface, QueryRunner } from 'typeorm';

export class Car1710844466496 implements MigrationInterface {
  name = 'Car1710844466496';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `CREATE TABLE "cars_photos" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "publicId" character varying NOT NULL, "blurHash" character varying NOT NULL, "profileUrl" character varying NOT NULL, "mobileUrl" character varying NOT NULL, "webUrl" character varying NOT NULL, "carId" uuid NOT NULL, CONSTRAINT "REL_e849099cf387e9ac4e18485c03" UNIQUE ("carId"), CONSTRAINT "PK_84b2f690cf5d28768abacd98c74" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "cars" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "model" character varying NOT NULL, "brand" character varying NOT NULL, "color" character varying NOT NULL, "driverId" uuid NOT NULL, "photoId" uuid, CONSTRAINT "REL_52439e2ced840f1d17e17c27d2" UNIQUE ("photoId"), CONSTRAINT "PK_fc218aa84e79b477d55322271b6" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `ALTER TABLE "cars_photos" ADD CONSTRAINT "FK_e849099cf387e9ac4e18485c03f" FOREIGN KEY ("carId") REFERENCES "cars"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "cars" ADD CONSTRAINT "FK_d6b2e2318f189e47c39984bc3ff" FOREIGN KEY ("driverId") REFERENCES "drivers"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "cars" ADD CONSTRAINT "FK_52439e2ced840f1d17e17c27d2e" FOREIGN KEY ("photoId") REFERENCES "cars_photos"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "cars" DROP CONSTRAINT "FK_52439e2ced840f1d17e17c27d2e"`,
    );
    await queryRunner.query(
      `ALTER TABLE "cars" DROP CONSTRAINT "FK_d6b2e2318f189e47c39984bc3ff"`,
    );
    await queryRunner.query(
      `ALTER TABLE "cars_photos" DROP CONSTRAINT "FK_e849099cf387e9ac4e18485c03f"`,
    );
    await queryRunner.query(`DROP TABLE "cars"`);
    await queryRunner.query(`DROP TABLE "cars_photos"`);
  }
}
