import { Navbar } from "@/components/navbar";

export default async function Home() {
  return (
    <div className="w-full px-5 max-w-6xl mx-auto">
      <Navbar />
      <div className="mt-20">
        <div className="text-3xl">hello world</div>
        <div className="text-sm text-muted-foreground mt-2">
          cok acayip bir seydir hello world hani gelir boyle ben hello worldum der hello world
          ooauuhhh yani hani oaaauuhhhh
        </div>
      </div>
    </div>
  );
}
