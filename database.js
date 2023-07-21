var db;
function initDatabase() {
    db = LocalStorage.openDatabaseSync("property", "1.0", "property", 100000);
    try {
        db.transaction(function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS data(parking INTEGER, name TEXT, num TEXT, date TEXT)')
        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    }
}
function getParkingData(parking) {
    if (!db) { return; }
    var res = "";
    db.transaction(function(tx) {
        var result = tx.executeSql('SELECT VALUE FROM data WHERE parking=?', [parking]);
        if (result.rows.length > 0) {
            res = result.rows.item(0).value;
        } else {
            res = "Unknown";
        }
    })
}
function getNameData(name) {
    if (!db) { return; }
    var res = "";
    db.transaction(function(tx) {
        var result = tx.executeSql('SELECT VALUE FROM data WHERE name=?', [name]);
        if (result.rows.length > 0) {
            res = result.rows.item(0).value;
        } else {
            res = "Unknown";
        }
    })
    return res;
}
function getNumData(num) {
    if (!db) { return; }
    var res = "";
    db.transaction(function(tx) {
        var result = tx.executeSql('SELECT VALUE FROM data WHERE num=?', [num]);
        if (result.rows.length > 0) {
            res = result.rows.item(0).value;
        } else {
            res = "Unknown";
        }
    })
    return res;
}
function insertData(name, num, date) {
    if (!db) { return; }
    var res = "";
    db.transaction(function(tx) {
        var result = tx.executeSql('INSERT OR REPLACE INFO data VALUES (?,?,?);', [name, num, date]);
        if (result.rowsAffected > 0) {
            res = "OK";
        } else {
            res = "Error";
        }
    })
    return res;
}
