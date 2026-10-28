<?php
header('Content-Type: application/json');

$pdo = new PDO("mysql:host=localhost;dbname=tienda_db;charset=utf8mb4", "root", "");

$action = $_GET['action'] ?? '';
$input = json_decode(file_get_contents('php://input'), true) ?? [];

if ($action === 'filtros') {
    echo json_encode([
        'categorias' => $pdo->query('SELECT * FROM categorias')->fetchAll(PDO::FETCH_ASSOC),
        'marcas' => $pdo->query('SELECT * FROM marcas')->fetchAll(PDO::FETCH_ASSOC)
    ]);
    exit;
}

if ($action === 'productos') {
    $cat = $_GET['categoria'] ?? '';
    $marca = $_GET['marca'] ?? '';
    $sql = 'SELECT p.*, m.nombre as marca_nombre FROM productos p JOIN marcas m ON p.id_marca = m.id WHERE 1=1';
    $params = [];
    
    if ($cat) { $sql .= ' AND p.id_categoria = ?'; $params[] = $cat; }
    if ($marca) { $sql .= ' AND p.id_marca = ?'; $params[] = $marca; }
    
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
    exit;
}

if ($action === 'registro') {
    $hash = password_hash($input['password'], PASSWORD_BCRYPT);
    try {
        $stmt = $pdo->prepare('INSERT INTO usuarios (nombre, email, password) VALUES (?, ?, ?)');
        $stmt->execute([$input['nombre'], $input['email'], $hash]);
        echo json_encode(['ok' => true, 'mensaje' => 'Usuario registrado con éxito']);
    } catch (Exception $e) {
        echo json_encode(['ok' => false, 'mensaje' => 'El correo ya existe']);
    }
    exit;
}

if ($action === 'login') {
    $stmt = $pdo->prepare('SELECT * FROM usuarios WHERE email = ?');
    $stmt->execute([$input['email']]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($user && password_verify($input['password'], $user['password'])) {
        echo json_encode(['ok' => true, 'usuario' => $user['nombre'] ?: $user['email']]);
    } else {
        echo json_encode(['ok' => false, 'mensaje' => 'Credenciales incorrectas']);
    }
    exit;
}

if ($action === 'contacto') {
    $stmt = $pdo->prepare('INSERT INTO contactos (nombre, email, mensaje) VALUES (?, ?, ?)');
    $stmt->execute([$input['nombre'], $input['email'], $input['mensaje']]);
    echo json_encode(['ok' => true, 'mensaje' => 'Mensaje enviado correctamente']);
    exit;
}
