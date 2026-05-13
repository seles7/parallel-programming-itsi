import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.util.Scanner;

public class Client {
    private static final String SERVER_ADDRESS = "localhost";
    private static final int SERVER_PORT = 7777;

    private static Socket socket;
    private static PrintWriter out;
    private static BufferedReader in;
    private static Scanner scanner;
    private static String clientName;
    private static String quitCommand = "/quit";

    public static void main(String[] args) {
        try {
            socket = new Socket(SERVER_ADDRESS, SERVER_PORT);
            System.out.println("Вы подключились к серверу " + SERVER_ADDRESS + ":" + SERVER_PORT);
            System.out.println("Для отключения от сервера введите " + quitCommand);

            in = new BufferedReader(new InputStreamReader(socket.getInputStream(), StandardCharsets.UTF_8));
            out = new PrintWriter(new OutputStreamWriter(socket.getOutputStream(), StandardCharsets.UTF_8), true);

            // Поток для обработки внешних сообщений
            Thread messageReader = new Thread(() -> {
                try {
                    String serverResponse;
                    while ((serverResponse = in.readLine()) != null) {
                        System.out.println(serverResponse);
                    }
                } catch (IOException e) {
                    System.err.println("Соединение разорвано.");
                    System.exit(0);
                }
            });
            messageReader.start();

            // Обработка ввода клиента
            scanner = new Scanner(System.in, "UTF-8");

            System.out.print("Введите ваше имя: ");
            clientName = scanner.nextLine();
            out.println(clientName);

            String userInput;
            while (true) {
                userInput = scanner.nextLine();
                out.println(userInput);
                if (userInput.equalsIgnoreCase(quitCommand)) {
                    break;
                }
            }
        } catch (IOException e) {
            System.err.println("Ошибка подключения к серверу: " + e.getMessage());
        }
        

        // Закрываем ресурсы
        try {
            socket.close();      
            scanner.close();
            System.out.println("Вы отключились от сервера.");
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.exit(0);
    }
}