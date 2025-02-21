<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Menu;
use Illuminate\Http\Request;

class MenuController extends Controller
{
    public function index()
    {
        // Ambil semua data menu dari database
        $menus = Menu::all();
        return response()->json($menus);
    }
}
