import { Payment } from "./columns";

export default async function Page() {
  const data = await getData();

  return <div className="container mx-auto py-10"></div>;
}
async function getData(): Promise<Payment[]> {
  // Fetch data from your API here.
  return [
    {
      id: "728ed52f",
      amount: 100,
      status: "pending",
      email: "m@example.com",
    },
    // ...
  ];
}
