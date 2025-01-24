package u4w3.entities;

import static u4w3.Utils.*;

import jakarta.persistence.*;

@Entity
@Table(name = "libri")
@PrimaryKeyJoinColumn(name = "id")
public class Libro extends ElementoCatalogo {

    @Column(nullable = false)
    private String autore;

    @Column(nullable = false)
    private String genere;

    // Getter e Setter
    public String getAutore() {
        return autore;
    }

    public void setAutore(String autore) {
        this.autore = autore;
    }

    public String getGenere() {
        return genere;
    }

    public void setGenere(String genere) {
        this.genere = genere;
    }

    @Override
    public String toString() {
        return super.toString() + String.format(" %-20s | %-10s | %-11s |", _T(autore, 20), _T(genere, 10), "") + "\n"
                + "-".repeat(132);
    }
}