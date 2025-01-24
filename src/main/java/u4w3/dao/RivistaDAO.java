package u4w3.dao;

import u4w3.entities.Rivista;
import jakarta.persistence.EntityManager;
import u4w3.exception.ErroreGenericoException;

import java.util.List;

public class RivistaDAO {

    private final EntityManager em;

    public RivistaDAO(EntityManager em) {
        this.em = em;
    }

    public List<Rivista> findByPeriodicita(Rivista.Periodicita periodicita) throws ErroreGenericoException {
        try {
            return em.createQuery("SELECT r FROM Rivista r WHERE r.periodicita = :periodicita", Rivista.class)
                    .setParameter("periodicita", periodicita)
                    .getResultList();
        } catch (Exception e) {
            throw new ErroreGenericoException(
                    "Errore durante la ricerca delle riviste per periodicità: " + e.getMessage());
        }
    }
}