import java.io.*;
import java.net.*;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.Scanner;

public class Server {
    private static final int PORT = 12346;
    private static ServerSocket serverSocket;
    private static Scanner scanner;
    private static CopyOnWriteArrayList<ClientHandler> clients = new CopyOnWriteArrayList<>();
    private static String quitCommand = "/quit";

    public static void main(String[] args) {
        try {
            serverSocket = new ServerSocket(PORT);
            System.out.println("Сервер запущен и ожидает клиентов.");
            System.out.println("Для отключения сервера введите " + quitCommand);

            // Поток для чтения ввода с консоли сервера
            Thread consoleReader = new Thread(() -> {
                scanner = new Scanner(System.in, "UTF-8");
                
                while (true) {
                    String message = scanner.nextLine();
                    
                    if (message.equalsIgnoreCase(quitCommand)) {
                        System.out.println("Получена команда отключения сервера...");
                        try {
                            broadcast("Сервер отключён.", null);
                            serverSocket.close();
                            scanner.close();
                        } catch (IOException e) {
                        }
                        break; // Выходим из потока консоли
                    }
                    if (message != null && !message.trim().isEmpty()) {
                        broadcast("[Сервер]: " + message, null);
                    }
                }
            });
            consoleReader.start();

            // Цикл, в котором сервер принимает новых клиентов
            while (true) {
                Socket clientSocket = serverSocket.accept();
                System.out.println("Подключается новый клиент...");

                // Создание обработчика нового клиента
                ClientHandler clientHandler = new ClientHandler(clientSocket);
                clients.add(clientHandler);
                new Thread(clientHandler).start();
            }
        } catch (IOException e) {
        } 
    }

    // Отправка сообщения всем подключённым клиентам
    public static void broadcast(String message, ClientHandler sender) {
        System.out.println(message);
        for (ClientHandler client : clients) {
            if (client != sender) {
                client.sendMessage(message);
            }
        }
    }

    // Внутренний класс для обработки клиентских подключений
    private static class ClientHandler implements Runnable {
        private Socket clientSocket;
        private PrintWriter out;
        private BufferedReader in;
        private String clientname;
        private String quitCommand = "/quit";

        public ClientHandler(Socket socket) {
            this.clientSocket = socket;

            try {
                out = new PrintWriter(socket.getOutputStream(), true);
                in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            } catch (IOException e) {
                System.err.println(e.getMessage());
            }
        }

        // Метод, исполняемый каждым клиентом
        @Override
        public void run() {
            try {
                clientname = in.readLine();
                broadcast("Клиент " + clientname + " подключился к чату.", this);
                sendMessage("Добро пожаловать в чат, " + clientname + "!");

                String inputLine;
                // Цикл ожидания ввода сообщений
                while ((inputLine = in.readLine()) != null) {
                    if (inputLine.equalsIgnoreCase(quitCommand)) {
                        break; // если пользователь ввел команду выхода то далее выполняется блок finally
                    }
                    broadcast("[" + clientname + "]: " + inputLine, null);
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    // Исключение клиента из списка подключённых клиентов
                    broadcast("Клиент " + clientname + " покинул чат.", this);
                    in.close();
                    out.close();
                    clients.remove(this);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        // Отправка сообщения конкретному клиенту
        public void sendMessage(String message) {
            if (out != null && !clientSocket.isClosed()) {
                out.println(message);
            }
        }
    }
}