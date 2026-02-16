import socket
import time
import math

# Налаштування
UDP_IP = "127.0.0.1"
UDP_PORT = 5001
FPS = 20                 # Частота (Гц)
DELAY = 1.0 / FPS        # Пауза між кадрами (0.04 сек)
STEP = 0.1               # Крок зміни кута (радіани)

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

current_angle = 0.0

try:
    while True:
        # 1. Змінюємо кут
        current_angle += STEP

        # 2. Нормалізація (Wrap around)
        # Щоб значення завжди було між -PI і +PI (для коректної роботи Слайдера)
        if current_angle > math.pi:
            current_angle -= 2 * math.pi
        elif current_angle < -math.pi:
            current_angle += 2 * math.pi

        # 3. Відправка
        message = str(current_angle).encode('utf-8')
        sock.sendto(message, (UDP_IP, UDP_PORT))

        # Вивід у консоль (можна закоментувати, щоб не спамило)
        # print(f"📡 Angle: {current_angle:.2f}")

        # 4. Чекаємо (1/25 секунди)
        time.sleep(DELAY)

except KeyboardInterrupt:
    print("\n🛑 Зупинено")
    sock.close()
