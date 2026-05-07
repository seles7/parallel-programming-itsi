import java.util.concurrent.Semaphore;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.locks.ReentrantLock;

public class MySemaphore extends Semaphore {

    private final ReentrantLock lock = new ReentrantLock();
    private final AtomicInteger permits;


    public MySemaphore(int initialPermits) {

        super(initialPermits);
        permits = new AtomicInteger(initialPermits);
    }

    @Override
    public void acquire() {

        String threadName = Thread.currentThread().getName();
        System.out.println(
                "Поток " + threadName + " ожидает пользовательский семафор. Свободные места: " + availablePermits());
        try {
            while (true) {
                lock.lock();
                if (permits.get() > 0) {
                    permits.decrementAndGet();
                    return;
                }
                lock.unlock();
            }
        } finally {
            System.out.println(
                    "Поток " + threadName + " занял пользовательский семафор. Свободные места: " + availablePermits());
            lock.unlock();
        }
    }

    @Override
    public void release() {

        String threadName = Thread.currentThread().getName();
        
        lock.lock();
        try {
            permits.incrementAndGet();

        } finally {
            System.out.println(
                    "Поток " + threadName + " освободил пользовательский семафор. Свободные места: " + availablePermits());
            lock.unlock();
        }
    }

    @Override
    public int availablePermits() {
        return permits.get();
    }
}
