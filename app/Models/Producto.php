<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Producto extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_producto'; //Definir la primary key

    protected $fillable = [
        'id_producto',
        'producto',
        'descripcion',
        'precio_costo',
        'precio_venta',
        'fecha_creacion',
        'marca'
    ];
}
