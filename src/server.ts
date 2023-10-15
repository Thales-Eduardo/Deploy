import cors from "cors";
import express, { NextFunction, Request, Response } from "express";
import "express-async-errors";

import helmet from "helmet";
import { AppErrors } from "./errors";

const processId = process.pid;
const app = express();
const port = 3333;

app.use(helmet());
app.use(express.json());
app.use(cors());

app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
  if (err instanceof AppErrors) {
    return res.status(err.statusCode).json({
      status: "error",
      message: err.message,
    });
  }

  console.error(err);

  return res.status(500).json({
    status: "error",
    message: "Internal server error",
  });
});

app.get("/", async (req, res) => {
  const origin = req.headers.host;
  console.log("passou aq", origin);

  res.send("Hello World");
});

const server = app.listen(port, () => {
  console.log(`http://localhost:${port} 🔥🔥🚒 ${processId}`);
});

// ---- Graceful Shutdown
function gracefulShutdown(event: any) {
  const data = new Date().toLocaleString();
  return (code: any) => {
    console.log(`${event} - server ending ${code}`, data);
    server.close(async () => {
      process.exit(0);
    });
  };
}

//disparado no ctrl+c => multiplataforma
process.on("SIGINT", gracefulShutdown("SIGINT"));
//Para aguardar as conexões serem encerradas para só então encerrar a aplicação.
process.on("SIGTERM", gracefulShutdown("SIGTERM"));

// captura erros não tratados
process.on("uncaughtException", (error, origin) => {
  console.log(`${origin} uncaughtException -  signal received ${error}`);
});
process.on("unhandledRejection", (error) => {
  console.log(`unhandledRejection - signal received ${error}`);
});

process.on("exit", (code) => {
  console.log(`exit signal received ${code}`);
});

// // simular um erro
// setTimeout(() => {
//   process.exit(1);
// }, Math.random() * 1e4); // 10.000
