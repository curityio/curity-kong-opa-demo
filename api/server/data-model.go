package main

type Records struct {
	Records []Record `json:"records"`
}

type Record struct {
	ID      int    `json:"id"`
	Patient string `json:"patient"`
	Doctor  string `json:"doctor"`
	Region  string `json:"region"`
	Notes   string `json:"notes"`
}
