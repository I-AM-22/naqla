import Image from "next/image";
import { FC, ReactNode } from "react";
export type AuthLayoutProps = {
  heading: string;
  subheading: string;
  children: ReactNode;
};
export const AuthLayout: FC<AuthLayoutProps> = ({
  heading,
  subheading,
  children,
}) => {
  return (
    <div className="flex h-full flex-1 flex-col">
      <div className="absolute top-0 mx-auto w-full px-8 pt-8 sm:px-6 sm:pt-6 lg:px-8 lg:pt-8">
        <nav className="relative flex items-center justify-between sm:h-10">
          <div className="flex flex-shrink-0 flex-grow items-center lg:flex-grow-0">
            <div className="flex w-full items-center justify-between md:w-auto">
              <Image
                src={"/logo-light.svg"}
                alt="Logo"
                height={24}
                className="dark:hidden"
                width={120}
              />
              <Image
                src={"/logo-dark.svg"}
                alt="Logo"
                height={24}
                className="hidden dark:block"
                width={120}
              />
            </div>
          </div>
        </nav>
      </div>
      <div className="flex flex-1">
        <main className="flex flex-1 flex-shrink-0 flex-col items-center border-r bg-background px-5 pb-8 pt-16 ">
          <div className="flex w-[330px] flex-1 flex-col justify-center sm:w-[384px]">
            <div className="mb-10">
              <h1 className="mb-2 mt-8 text-2xl lg:text-3xl">{heading}</h1>
              <h2 className="text-foreground-light text-lg">{subheading}</h2>
            </div>
            {children}
          </div>
        </main>
        <aside className="hidden flex-1 flex-shrink basis-1/4 flex-col items-center justify-center bg-gradient-to-tr from-primary-foreground to-yellow-700 xl:flex"></aside>
      </div>
    </div>
  );
};
