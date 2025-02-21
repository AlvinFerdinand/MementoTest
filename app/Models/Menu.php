<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Menu extends Model
{
    use HasFactory;

    /**
     * Kolom-kolom yang dapat di mass assign.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'description',
        'price',
        'image',
    ];
}
