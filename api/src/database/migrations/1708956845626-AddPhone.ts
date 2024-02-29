import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddPhone1708956845626 implements MigrationInterface {
  name = 'AddPhone1708956845626';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `CREATE TABLE "permissions" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "action" character varying NOT NULL, "subject" character varying NOT NULL, CONSTRAINT "un_permission" UNIQUE ("action", "subject"), CONSTRAINT "PK_920331560282b8bd21bb02290df" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "users_photos" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "publicId" character varying NOT NULL, "blurHash" character varying NOT NULL, "profileUrl" character varying NOT NULL, "mobileUrl" character varying NOT NULL, "webUrl" character varying NOT NULL, "userId" uuid NOT NULL, CONSTRAINT "PK_1d98b9902c6e5bbb2e1449e1312" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "admins" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "firstName" character varying NOT NULL, "lastName" character varying NOT NULL, "phone" character varying NOT NULL, "password" character varying NOT NULL, "passwordChangedAt" TIMESTAMP, "passwordResetToken" character varying, "passwordResetExpires" TIMESTAMP, "roleId" uuid NOT NULL, CONSTRAINT "UQ_bacf1cabdd51dca73d1a57ea66d" UNIQUE ("phone"), CONSTRAINT "UQ_eba46414aacd2fe49604fc2bcdd" UNIQUE ("passwordResetToken"), CONSTRAINT "PK_e3b38270c97a854c48d2e80874e" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "admins_photos" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "publicId" character varying NOT NULL, "blurHash" character varying NOT NULL, "profileUrl" character varying NOT NULL, "mobileUrl" character varying NOT NULL, "webUrl" character varying NOT NULL, "adminId" uuid NOT NULL, CONSTRAINT "PK_7fc3580e6921a424d40877f65a5" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "employees_photos" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "publicId" character varying NOT NULL, "blurHash" character varying NOT NULL, "profileUrl" character varying NOT NULL, "mobileUrl" character varying NOT NULL, "webUrl" character varying NOT NULL, "employeeId" uuid NOT NULL, CONSTRAINT "PK_f8bfbef525b349c489f6a8adc7a" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "employees" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "firstName" character varying NOT NULL, "lastName" character varying NOT NULL, "phone" character varying NOT NULL, "password" character varying NOT NULL, "passwordChangedAt" TIMESTAMP, "passwordResetToken" character varying, "passwordResetExpires" TIMESTAMP, "address" character varying NOT NULL, "storeId" character varying NOT NULL, "roleId" uuid NOT NULL, CONSTRAINT "UQ_cbc362d1c574464a63d3acc3ead" UNIQUE ("phone"), CONSTRAINT "UQ_27349e0e76d5548d6773ad974cd" UNIQUE ("passwordResetToken"), CONSTRAINT "PK_b9535a98350d5b26e7eb0c26af4" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "roles" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "name" character varying NOT NULL, CONSTRAINT "UQ_648e3f5447f725579d7d4ffdfb7" UNIQUE ("name"), CONSTRAINT "PK_c1433d71a4838793a49dcad46ab" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "users" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "firstName" character varying NOT NULL, "lastName" character varying NOT NULL, "phone" character varying NOT NULL, "password" character varying NOT NULL, "passwordChangedAt" TIMESTAMP, "passwordResetToken" character varying, "passwordResetExpires" TIMESTAMP, "roleId" uuid NOT NULL, CONSTRAINT "UQ_a000cca60bcf04454e727699490" UNIQUE ("phone"), CONSTRAINT "UQ_bffe933a388d6bde48891ff95ab" UNIQUE ("passwordResetToken"), CONSTRAINT "PK_a3ffb1c0c8416b9fc6f907b7433" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "users_wallets" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "userId" uuid NOT NULL, "total" integer NOT NULL DEFAULT '0', "pending" integer NOT NULL DEFAULT '0', CONSTRAINT "REL_b6504ce4d4359e72872c0bef14" UNIQUE ("userId"), CONSTRAINT "PK_1d08bf0e6818dbad61210ab2c10" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "drivers" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "firstName" character varying NOT NULL, "lastName" character varying NOT NULL, "phone" character varying NOT NULL, "password" character varying NOT NULL, "passwordChangedAt" TIMESTAMP, "passwordResetToken" character varying, "passwordResetExpires" TIMESTAMP, CONSTRAINT "UQ_b97a5a68c766d2d1ec25e6a85b2" UNIQUE ("phone"), CONSTRAINT "UQ_f8e32d615cfd3bceecd6fec2331" UNIQUE ("passwordResetToken"), CONSTRAINT "PK_92ab3fb69e566d3eb0cae896047" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "cities" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "name" character varying NOT NULL, CONSTRAINT "UQ_a0ae8d83b7d32359578c486e7f6" UNIQUE ("name"), CONSTRAINT "PK_4762ffb6e5d198cfec5606bc11e" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "roles_permissions" ("roleId" uuid NOT NULL, "permissionId" uuid NOT NULL, CONSTRAINT "PK_5829481fc2a13d85b9b6bf3bd53" PRIMARY KEY ("roleId", "permissionId"))`,
    );
    await queryRunner.query(
      `CREATE INDEX "IDX_28bf280551eb9aa82daf1e156d" ON "roles_permissions" ("roleId") `,
    );
    await queryRunner.query(
      `CREATE INDEX "IDX_31cf5c31d0096f706e3ba3b1e8" ON "roles_permissions" ("permissionId") `,
    );
    await queryRunner.query(
      `ALTER TABLE "users_photos" ADD CONSTRAINT "FK_7754692648dc48f4a302cdb43e6" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "admins" ADD CONSTRAINT "FK_d27f7a7f01967e4a5e8ba73ebb0" FOREIGN KEY ("roleId") REFERENCES "roles"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "admins_photos" ADD CONSTRAINT "FK_91b0dd8eec211456abe412034fc" FOREIGN KEY ("adminId") REFERENCES "admins"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "employees_photos" ADD CONSTRAINT "FK_a9a6be77280915366cae03edc58" FOREIGN KEY ("employeeId") REFERENCES "employees"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "employees" ADD CONSTRAINT "FK_24d98872eb52c3edb30ce96c1e9" FOREIGN KEY ("roleId") REFERENCES "roles"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "users" ADD CONSTRAINT "FK_368e146b785b574f42ae9e53d5e" FOREIGN KEY ("roleId") REFERENCES "roles"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "users_wallets" ADD CONSTRAINT "FK_b6504ce4d4359e72872c0bef149" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "roles_permissions" ADD CONSTRAINT "FK_28bf280551eb9aa82daf1e156d9" FOREIGN KEY ("roleId") REFERENCES "roles"("id") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
    await queryRunner.query(
      `ALTER TABLE "roles_permissions" ADD CONSTRAINT "FK_31cf5c31d0096f706e3ba3b1e82" FOREIGN KEY ("permissionId") REFERENCES "permissions"("id") ON DELETE CASCADE ON UPDATE NO ACTION`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "roles_permissions" DROP CONSTRAINT "FK_31cf5c31d0096f706e3ba3b1e82"`,
    );
    await queryRunner.query(
      `ALTER TABLE "roles_permissions" DROP CONSTRAINT "FK_28bf280551eb9aa82daf1e156d9"`,
    );
    await queryRunner.query(
      `ALTER TABLE "users_wallets" DROP CONSTRAINT "FK_b6504ce4d4359e72872c0bef149"`,
    );
    await queryRunner.query(
      `ALTER TABLE "users" DROP CONSTRAINT "FK_368e146b785b574f42ae9e53d5e"`,
    );
    await queryRunner.query(
      `ALTER TABLE "employees" DROP CONSTRAINT "FK_24d98872eb52c3edb30ce96c1e9"`,
    );
    await queryRunner.query(
      `ALTER TABLE "employees_photos" DROP CONSTRAINT "FK_a9a6be77280915366cae03edc58"`,
    );
    await queryRunner.query(
      `ALTER TABLE "admins_photos" DROP CONSTRAINT "FK_91b0dd8eec211456abe412034fc"`,
    );
    await queryRunner.query(
      `ALTER TABLE "admins" DROP CONSTRAINT "FK_d27f7a7f01967e4a5e8ba73ebb0"`,
    );
    await queryRunner.query(
      `ALTER TABLE "users_photos" DROP CONSTRAINT "FK_7754692648dc48f4a302cdb43e6"`,
    );
    await queryRunner.query(
      `DROP INDEX "public"."IDX_31cf5c31d0096f706e3ba3b1e8"`,
    );
    await queryRunner.query(
      `DROP INDEX "public"."IDX_28bf280551eb9aa82daf1e156d"`,
    );
    await queryRunner.query(`DROP TABLE "roles_permissions"`);
    await queryRunner.query(`DROP TABLE "cities"`);
    await queryRunner.query(`DROP TABLE "drivers"`);
    await queryRunner.query(`DROP TABLE "users_wallets"`);
    await queryRunner.query(`DROP TABLE "users"`);
    await queryRunner.query(`DROP TABLE "roles"`);
    await queryRunner.query(`DROP TABLE "employees"`);
    await queryRunner.query(`DROP TABLE "employees_photos"`);
    await queryRunner.query(`DROP TABLE "admins_photos"`);
    await queryRunner.query(`DROP TABLE "admins"`);
    await queryRunner.query(`DROP TABLE "users_photos"`);
    await queryRunner.query(`DROP TABLE "permissions"`);
  }
}
