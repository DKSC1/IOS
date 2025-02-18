// server.ts

import { Application, Context } from "https://deno.land/x/oak/mod.ts";

const app = new Application();

const paymentData = {
  cardNumber: "1234567890123456", // przykładowe dane karty
  expiryDate: "12/12",            // przykładowa data ważności
  cvv: "123"                      // przykładowy kod CVV
};

app.use(async (ctx: Context) => {
  if (ctx.request.method === "POST" && ctx.request.url.pathname === "/payment") {
    try {
      const body = await ctx.request.body().value;
      const { cardNumber, expiryDate, cvv } = body;

      if (cardNumber === paymentData.cardNumber && expiryDate === paymentData.expiryDate && cvv === paymentData.cvv) {
        ctx.response.status = 200;
        ctx.response.body = { message: "Płatność przeszła pomyślnie!" };
      } else {
        ctx.response.status = 400;
        ctx.response.body = { message: "Niepoprawne dane płatności." };
      }
    } catch (e) {
      ctx.response.status = 500;
      ctx.response.body = { message: "Błąd serwera." };
    }
  }
});

console.log("Server running on http://localhost:3000");
await app.listen({ port: 3000 });
