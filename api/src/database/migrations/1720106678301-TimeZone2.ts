import { MigrationInterface, QueryRunner } from "typeorm";

export class TimeZone21720106678301 implements MigrationInterface {
    name = 'TimeZone21720106678301'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "permissions" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "permissions" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "permissions" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "permissions" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "permissions" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "permissions" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "admins_photos" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "admins_photos" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "admins_photos" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "admins_photos" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "admins_photos" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "admins_photos" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "admins" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "admins" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "admins" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "admins" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "admins" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "admins" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "admins" DROP COLUMN "passwordChangedAt"`);
        await queryRunner.query(`ALTER TABLE "admins" ADD "passwordChangedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "admins" DROP COLUMN "passwordResetExpires"`);
        await queryRunner.query(`ALTER TABLE "admins" ADD "passwordResetExpires" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "employees_photos" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "employees_photos" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "employees_photos" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "employees_photos" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "employees_photos" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "employees_photos" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "employees" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "employees" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "employees" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "employees" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "employees" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "employees" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "employees" DROP COLUMN "passwordChangedAt"`);
        await queryRunner.query(`ALTER TABLE "employees" ADD "passwordChangedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "employees" DROP COLUMN "passwordResetExpires"`);
        await queryRunner.query(`ALTER TABLE "employees" ADD "passwordResetExpires" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "drivers_photos" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "drivers_photos" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "drivers_photos" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "drivers_photos" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "drivers_photos" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "drivers_photos" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "drivers_wallets" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "drivers_wallets" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "drivers_wallets" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "drivers_wallets" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "drivers_wallets" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "drivers_wallets" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "cars_photos" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "cars_photos" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "cars_photos" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "cars_photos" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "cars_photos" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "cars_photos" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "messages" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "messages" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "messages" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "messages" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "messages" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "messages" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "acceptedAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "acceptedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "arrivedAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "arrivedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "deliveredAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "deliveredAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "driverAssignedAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "driverAssignedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "pickedUpAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "pickedUpAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "orders_photos" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "orders_photos" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "orders_photos" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "orders_photos" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "orders_photos" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "orders_photos" ADD "deletedAt" TIMESTAMP WITH TIME ZONE `);
        await queryRunner.query(`ALTER TABLE "payments" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "payments" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "payments" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "payments" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "payments" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "payments" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "payments" DROP COLUMN "deliveredDate"`);
        await queryRunner.query(`ALTER TABLE "payments" ADD "deliveredDate" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "orders" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "orders" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "orders" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "orders" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "orders" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "orders" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "orders" DROP COLUMN "desiredDate"`);
        await queryRunner.query(`ALTER TABLE "orders" ADD "desiredDate" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`UPDATE "orders" SET "desiredDate" = now() WHERE "desiredDate" IS NULL`);
        await queryRunner.query(`ALTER TABLE "orders" ALTER COLUMN "desiredDate" SET NOT NULL`);
        await queryRunner.query(`ALTER TABLE "advantages" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "advantages" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "advantages" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "advantages" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "advantages" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "advantages" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "cars" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "cars" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "cars" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "cars" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "cars" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "cars" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "drivers" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "drivers" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "drivers" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "drivers" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "drivers" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "drivers" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "roles" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "roles" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "roles" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "roles" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "roles" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "roles" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "users_photos" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "users_photos" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "users_photos" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "users_photos" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "users_photos" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "users_photos" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "users_wallets" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "users_wallets" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "users_wallets" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "users_wallets" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "users_wallets" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "users_wallets" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "users" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "users" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "users" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "users" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "users" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "users" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "settings" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "settings" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "settings" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "settings" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "settings" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "settings" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "otps" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "otps" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "otps" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "otps" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "otps" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "otps" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`ALTER TABLE "otps" DROP COLUMN "expiresIn"`);
        await queryRunner.query(`ALTER TABLE "otps" ADD "expiresIn" TIMESTAMP WITH TIME ZONE`);
        await queryRunner.query(`UPDATE "otps" SET "expiresIn" = now() WHERE "expiresIn" IS NULL`);
        await queryRunner.query(`ALTER TABLE "otps" ALTER COLUMN "expiresIn" SET NOT NULL`);
        await queryRunner.query(`ALTER TABLE "cities" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "cities" ADD "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "cities" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "cities" ADD "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "cities" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "cities" ADD "deletedAt" TIMESTAMP WITH TIME ZONE`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "cities" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "cities" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "cities" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "cities" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "cities" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "cities" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "otps" DROP COLUMN "expiresIn"`);
        await queryRunner.query(`ALTER TABLE "otps" ADD "expiresIn" TIMESTAMP NOT NULL`);
        await queryRunner.query(`ALTER TABLE "otps" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "otps" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "otps" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "otps" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "otps" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "otps" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "settings" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "settings" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "settings" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "settings" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "settings" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "settings" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "users" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "users" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "users" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "users" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "users" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "users" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "users_wallets" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "users_wallets" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "users_wallets" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "users_wallets" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "users_wallets" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "users_wallets" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "users_photos" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "users_photos" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "users_photos" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "users_photos" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "users_photos" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "users_photos" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "roles" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "roles" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "roles" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "roles" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "roles" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "roles" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "drivers" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "drivers" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "drivers" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "drivers" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "drivers" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "drivers" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "cars" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "cars" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "cars" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "cars" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "cars" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "cars" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "advantages" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "advantages" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "advantages" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "advantages" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "advantages" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "advantages" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "orders" DROP COLUMN "desiredDate"`);
        await queryRunner.query(`ALTER TABLE "orders" ADD "desiredDate" TIMESTAMP NOT NULL`);
        await queryRunner.query(`ALTER TABLE "orders" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "orders" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "orders" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "orders" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "orders" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "orders" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "payments" DROP COLUMN "deliveredDate"`);
        await queryRunner.query(`ALTER TABLE "payments" ADD "deliveredDate" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "payments" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "payments" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "payments" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "payments" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "payments" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "payments" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "orders_photos" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "orders_photos" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "orders_photos" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "orders_photos" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "orders_photos" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "orders_photos" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "pickedUpAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "pickedUpAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "driverAssignedAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "driverAssignedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "deliveredAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "deliveredAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "arrivedAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "arrivedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "acceptedAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "acceptedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "sub_orders" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "sub_orders" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "messages" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "messages" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "messages" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "messages" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "messages" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "messages" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "cars_photos" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "cars_photos" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "cars_photos" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "cars_photos" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "cars_photos" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "cars_photos" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "drivers_wallets" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "drivers_wallets" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "drivers_wallets" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "drivers_wallets" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "drivers_wallets" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "drivers_wallets" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "drivers_photos" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "drivers_photos" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "drivers_photos" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "drivers_photos" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "drivers_photos" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "drivers_photos" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "employees" DROP COLUMN "passwordResetExpires"`);
        await queryRunner.query(`ALTER TABLE "employees" ADD "passwordResetExpires" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "employees" DROP COLUMN "passwordChangedAt"`);
        await queryRunner.query(`ALTER TABLE "employees" ADD "passwordChangedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "employees" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "employees" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "employees" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "employees" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "employees" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "employees" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "employees_photos" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "employees_photos" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "employees_photos" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "employees_photos" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "employees_photos" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "employees_photos" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "admins" DROP COLUMN "passwordResetExpires"`);
        await queryRunner.query(`ALTER TABLE "admins" ADD "passwordResetExpires" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "admins" DROP COLUMN "passwordChangedAt"`);
        await queryRunner.query(`ALTER TABLE "admins" ADD "passwordChangedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "admins" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "admins" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "admins" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "admins" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "admins" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "admins" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "admins_photos" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "admins_photos" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "admins_photos" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "admins_photos" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "admins_photos" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "admins_photos" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "permissions" DROP COLUMN "deletedAt"`);
        await queryRunner.query(`ALTER TABLE "permissions" ADD "deletedAt" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "permissions" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "permissions" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "permissions" DROP COLUMN "createdAt"`);
        await queryRunner.query(`ALTER TABLE "permissions" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`);
    }

}
