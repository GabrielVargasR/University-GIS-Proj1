from PyQt5.QtWidgets import * 
from PyQt5 import QtCore, QtGui 
from PyQt5.QtGui import * 
from PyQt5.QtCore import * 
from PyQt5.QtSql import *

# clase para manejar mas facil la conexion a la base de datos 
class DB():
    con = QSqlDatabase.addDatabase("QPSQL");
    def __init__(self):
        self.con.setHostName("localhost");
        self.con.setPort(5432);
        self.con.setDatabaseName("indigo");
        self.con.setUserName("postgres");
        self.con.open();
        
class Window(QMainWindow):
    # constructor de la clase
    def __init__(self):
        super().__init__();
        self.db = DB();
        self.drone = 0;
        self.drone_index = [];
        self.config = 0;
        self.config_index = [];
        self.productos = [22,23]; # valor alambrado temporalmente
        self.area = 10.0; # valor alambrado temporalmente
        self.setWindowTitle('Prueba de conexion');
        self.setGeometry(0,0,400,300);
        self.UiComponents();
        self.show();

    # para manejar la terminacion de la ventana
    def cerrarVentana(self):
        self.hide()

    # metodo alternativo para el boton de aceptar
    # mandaria a calcular dosis a base de datos
    def calcular_dosis(self):
        query = QSqlQuery(self.db.con)
        #ids_productos
        prods = 'ARRAY['
        for i in self.productos:
            prods += str(i) + ','
        prods = prods[:-1]
        prods += ']'
        
        # el ? en el query indica que ahi va un parametro
        query.prepare(f"select * from fn_calcular_dosis(?, ?, {prods}, ?);")
        query.bindValue(0, self.drone) # id_drone
        query.bindValue(1, self.config) # id_config
        #query.bindValue(2, prods) # ids_productos
        query.bindValue(2, self.area) # area calculada
        query.exec_()
        print(query.lastError().text())
        while (query.next()):
            print(query.value(0), query.value(1), query.value(2), query.value(3), query.value(9))
        
        

    # para manejar seleccion en combo box de drone
    # actualiza configuraciones
    def ver_drone_seleccionado(self,i):
        # se actualiza el id del drone actualmente seleccionado
        self.drone = self.drone_index[self.cb_drone.currentIndex()]
        
        # cada vez que se selecciona un drone nuevo, hay que cambiar las
        # configuraciones disponibles
        self.cb_config.clear() # elimina configuraciones del drone anterior
        
        query_config = QSqlQuery(self.db.con)
        # el ? en el query indica que ahi va un parametro
        query_config.prepare('select * from fn_listar_configuraciones(?);')
        query_config.bindValue(0,self.drone) #bindValue(param_index, param_value)
        query_config.exec_()
        
        self.config_index = []
        while (query_config.next()):
            self.config_index.append(query_config.value(0))
            # falta completar display
            self.cb_config.addItem(f'Id: {query_config.value(0)} - Altitud: {query_config.value(2)}')
    
    
    # para manejar seleccion de configuracion
    def ver_config_seleccionado(self, i):
        self.config = self.config_index[self.cb_config.currentIndex()]
        
    
    # metodo para componentes graficos
    def UiComponents(self): 
        
        # boton para aceptar
        # mandar a calcular dosis a la base de datos
        button = QPushButton(self)
        button.setText("Aceptar")
        button.setGeometry(10, 260, 120, 30) 
        button.pressed.connect(self.calcular_dosis)

        # combo box para seleccionar drone
        self.cb_drone = QComboBox(self)
        self.cb_drone.setGeometry(10, 10, 350, 30)
        self.cb_drone.currentIndexChanged.connect(self.ver_drone_seleccionado)

        # combo box para seleccionar configuracion
        self.cb_config = QComboBox(self)
        self.cb_config.setGeometry(10, 50, 350, 30)
        self.cb_config.currentIndexChanged.connect(self.ver_config_seleccionado)

        # queries para display
        query_drone = QSqlQuery(self.db.con)
        query_drone.exec_("select * from fn_listar_drones();")
        
        # query para listar drones
        while (query_drone.next()):
            self.drone_index.append(query_drone.value(0))
            self.cb_drone.addItem(f'Id: {query_drone.value(0)} - Duracion \
bateria: {query_drone.value(3)} - Capacidad: {query_drone.value(4)} litros')
        
        # query para listar productos
        query_productos = QSqlDatabase(self.db.con)
        query_drone.exec_("select * from fn_listar_productos();")
        # hay que pensar como listar los productos para que se puedan
        # seleccionar varios a la vez
        
        

window = Window()