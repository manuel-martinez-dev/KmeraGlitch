import os
import threading
from datetime import datetime
from signal import pause

from picamera2 import Picamera2
from gpiozero import Button

import config


def main():
    os.makedirs(config.SAVE_PATH, exist_ok=True)

    camera = Picamera2()
    camera_config = camera.create_still_configuration(
        main={"size": config.RESOLUTION}
    )
    camera.configure(camera_config)
    camera.start()

    _lock = threading.Lock()

    def capture_photo():
        if not _lock.acquire(blocking=False):
            print("Capture in progress, ignoring button press.")
            return
        try:
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            filename = f"photo_{timestamp}.png"
            filepath = os.path.join(config.SAVE_PATH, filename)
            camera.capture_file(filepath)
            print(f"Captured: {filepath}")
        except Exception as e:
            print(f"Capture failed: {e}")
        finally:
            _lock.release()

    button = Button(config.GPIO_PIN, pull_up=True, bounce_time=0.1)
    button.when_pressed = capture_photo

    print(f"KmeraGlitch ready. Waiting for button press on GPIO {config.GPIO_PIN}...")

    try:
        pause()
    finally:
        camera.stop()
        camera.close()


if __name__ == "__main__":
    main()
