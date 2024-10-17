<?php

namespace Database\Seeders;

use App\Models\Page;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class PageSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Page::factory()->create([
            'title' => 'Home'
        ]);
        Page::factory()->create([
            'title' => 'About'
        ]);
        Page::factory()->create([
            'title' => 'Contact'
        ]);
    }
}
