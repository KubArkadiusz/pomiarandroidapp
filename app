import tkinter as tk
import customtkinter as ctk
import requests
import pandas as pd
import os

class App(ctk.CTk):
    def __init__(self):
        super().__init__()

        self.title("System Pomiaru Czasu - Wiśniewo")
        self.geometry("400x500")

        # Konfiguracja URL (bezpośredni eksport do XLSX)
        self.FILE_URL = "https://docs.google.com/spreadsheets/d/1Iaj_ivUyrnRmRujm4PnPL_d1En3M9JLI/export?format=xlsx"
        self.LOCAL_FILE = "lista_startowa.xlsx"

        # Interfejs
        self.label = ctk.CTkLabel(self, text="PANEL STEROWANIA", font=("Arial", 20, "bold"))
        self.label.pack(pady=30)

        self.btn_download = ctk.CTkButton(self, text="POBIERZ LISTĘ STARTOWĄ", command=self.download_list)
        self.btn_download.pack(pady=15, padx=40, fill="x")

        self.btn_measure = ctk.CTkButton(self, text="POMIAR", command=self.start_measurement, fg_color="green")
        self.btn_measure.pack(pady=15, padx=40, fill="x")

        self.btn_send = ctk.CTkButton(self, text="WYŚLIJ", command=self.send_results, fg_color="darkblue")
        self.btn_send.pack(pady=15, padx=40, fill="x")

        self.status_label = ctk.CTkLabel(self, text="Status: Gotowy", text_color="gray")
        self.status_label.pack(side="bottom", pady=20)

    def download_list(self):
        try:
            self.status_label.configure(text="Pobieranie...", text_color="orange")
            self.update()
            
            response = requests.get(self.FILE_URL)
            with open(self.LOCAL_FILE, 'wb') as f:
                f.write(response.content)
            
            # Test odczytu
            df = pd.read_excel(self.LOCAL_FILE)
            self.status_label.configure(text=f"Pobrano! Zawodników: {len(df)}", text_color="green")
        except Exception as e:
            self.status_label.configure(text=f"Błąd: {str(e)}", text_color="red")

    def start_measurement(self):
        # Tutaj logika otwierania okna pomiaru
        self.status_label.configure(text="Tryb pomiaru aktywny", text_color="green")
        print("Rozpoczęto pomiar...")

    def send_results(self):
        # Tutaj logika wysyłki wyników
        self.status_label.configure(text="Wysyłanie wyników...", text_color="blue")

if __name__ == "__main__":
    app = App()
    app.mainloop()
