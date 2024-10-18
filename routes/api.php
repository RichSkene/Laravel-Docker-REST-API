<?php

use App\Http\Controllers\PageController;
use App\Http\Controllers\UserController;
use Illuminate\Foundation\Exceptions\Renderer\Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

Route::get('/', function () {
    return response()->json(['message' => 'Not Found!'], 404);
});
Route::post('/user/create-token', [UserController::class, 'createToken']);

Route::group(['prefix' => 'pages', 'middleware' => 'auth:sanctum'], function () {
    Route::get('/', [PageController::class, 'index']);
    Route::get('/{page:slug}', [PageController::class, 'show']);
});
