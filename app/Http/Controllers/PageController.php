<?php

namespace App\Http\Controllers;

use App\Models\Page;
use Illuminate\Http\Request;

class PageController
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $pages = Page::all();
        return ['pages' => $pages];
    }

    /**
     * Display the specified resource.
     */
    public function show(Page $page)
    {
        return ['page' => $page];
    }
}
