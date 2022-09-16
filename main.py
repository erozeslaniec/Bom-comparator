# This Python file uses the following encoding: utf-8

import sys, os

#sys.path.append(os.path.abspath('../backend/'))
#sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import backend.Compare as Comp

from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    compareClass = Comp.Compare()

    #compareClass.addFirstFile(surl="lalla")

    engine.rootContext().setContextProperty("backend", compareClass)




    qml_file = Path(__file__).resolve().parent / "qml/main.qml"
    engine.load(qml_file)

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
