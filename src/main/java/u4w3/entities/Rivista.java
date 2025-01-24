package u4w3.entities;

import static u4w3.Utils.*;

import jakarta.persistence.*;

@Entity
@Table(name = "riviste")
@PrimaryKeyJoinColumn(name = "id")
public class Rivista extends ElementoCatalogo {

    public enum Periodicita {
        SETTIMANALE, MENSILE, SEMESTRALE
    }

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Periodicita periodicita;

    // Getter e Setter
    public Periodicita getPeriodicita() {
        return periodicita;
    }

    public void setPeriodicita(Periodicita periodicita) {
        this.periodicita = periodicita;
    }

    @Override
    public String toString() {
        return super.toString()
                + String.format(" %-20s | %-11s | %-11s |", "", "", periodicita) + "\n" + "-".repeat(132);
    }
}