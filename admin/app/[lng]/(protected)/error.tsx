"use client";

import { SomethingWentWrong } from "@/components/ui/error";
import { useEffect } from "react";

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    console.log(error);
  }, [error]);
  return <SomethingWentWrong />;
}
