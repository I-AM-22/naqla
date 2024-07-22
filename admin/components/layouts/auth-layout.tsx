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
      <div className="absolute top-0 mx-auto w-full px-8 pt-6 md:pt-16">
        <nav className="relative flex items-center justify-between sm:h-10">
          <div className="flex flex-shrink-0 flex-grow items-center lg:flex-grow-0">
            <div className="flex w-full items-center justify-between md:w-auto">
              <Image
                src={"/logo.jpg"}
                className="block rounded-full xl:hidden"
                alt="Logo"
                height={24}
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
        <aside className="hidden flex-1 flex-shrink basis-1/4 flex-col items-center justify-center bg-gradient-to-tl from-primary-foreground to-blue-950/80 xl:flex dark:to-blue-600">
          <Image
            src={"/logo.jpg"}
            alt="Logo"
            height={30}
            className="rounded-full"
            width={180}
          />
        </aside>
      </div>
    </div>
  );
};
